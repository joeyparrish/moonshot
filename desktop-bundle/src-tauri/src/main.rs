// Prevents additional console window on Windows in release, DO NOT REMOVE!!
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use std::sync::mpsc;
use std::sync::mpsc::TryRecvError;
use steamworks::Client;
use steamworks::SingleClient;
use steamworks::SteamError;
use steamworks::UserStatsReceived;
use steamworks::UserStatsStored;
use tauri::Manager;

// Some Steamworks API callbacks have a result.  This trait is attached to
// those types.
trait SteamWorksCallbackWithResult : steamworks::Callback {
    fn get_result(&self) -> &Result<(), SteamError>;
}

// These are implementations of that trait for the specific callback types we
// care about below.
impl SteamWorksCallbackWithResult for UserStatsReceived {
    fn get_result(&self) -> &Result<(), SteamError> {
        return &self.result;
    }
}

impl SteamWorksCallbackWithResult for UserStatsStored {
    fn get_result(&self) -> &Result<(), SteamError> {
        return &self.result;
    }
}

// Trigger and wait on operations in Steamworks that require callback events to
// complete.  It would have been nice for the Rust wrapper to handle this for
// us and just give us an async function, but here we are.  This sets up a
// callback listener, triggers the operation, then processes callbacks in a
// loop until we get a success or failure.  If the callback isn't invoked
// within 5 seconds, we return a timeout error.  "ValType" is the type of
// callback event required for the specific operation, and "action" is a string
// used in error messages so we know which step failed.
fn await_steamworks_callback<ValType, F>(steam_client: &Client, single_client: &SingleClient, action: &str, mut operation: F) -> Result<(), String>
where
    ValType: SteamWorksCallbackWithResult,
    F: FnMut() -> ()
{
    let error_header = format!("Failed to {action}: ");
    let error_header_in_callback = error_header.clone();

    // Listen for callbacks and record the results via a channel.
    let (sender, receiver) = mpsc::channel();
    let handle = steam_client.register_callback(move |val: ValType| {
        if val.get_result().is_err() {
            let specific_error = val.get_result().unwrap_err().to_string();
            let full_error = format!("{error_header_in_callback}{specific_error}");
            sender.send(Err(full_error)).unwrap();
        } else {
            sender.send(Ok(())).unwrap();
        }
    });

    // Trigger the operation.
    operation();

    // Flush Steamworks callbacks every 100ms for up to 5s.
    for _ in 0..50 {
        single_client.run_callbacks();

        let maybe: Result<Result<(), String>, TryRecvError> = receiver.try_recv();
        if maybe.is_err() {
            // No result yet.  Sleep and try again.
            ::std::thread::sleep(::std::time::Duration::from_millis(100));
            continue;
        }

        // Disconnect the callback.
        handle.disconnect();

        // Process the result.
        let callback_result: Result<(), String> = maybe.unwrap();
        if callback_result.is_err() {
          return Err(callback_result.unwrap_err());
        } else {
          return Ok(callback_result.unwrap());
        }
    }

    // Disconnect the callback.
    handle.disconnect();

    // Return a timeout error.
    return Err(format!("{error_header}Steamworks API timeout!"));
}

// A Tauri command, invocable from JavaScript, that unlocks an achievement in
// Steam via the Steamworks API.
#[tauri::command]
fn unlock_achievement(name: String) -> Result<(), String> {
    println!("Unlocked achievement: {name}");

    let (steam_client, single_client) = match Client::init() {
        Ok(tuple) => tuple,
        Err(reason) => return Err(format!("Failed to init Steamworks: {reason}")),
    };

    let stats = steam_client.user_stats();
    await_steamworks_callback::<UserStatsReceived, _>(&steam_client, &single_client, "retrieve user stats", || {
        stats.request_current_stats();
    })?;

    stats.achievement(name.as_str()).set().unwrap();

    await_steamworks_callback::<UserStatsStored, _>(&steam_client, &single_client, "store user stats", || {
        stats.store_stats().unwrap();
    })?;

    return Ok(());
}

fn main() {
    tauri::Builder::default()
        // The shell plugin allows tauri to open external links in the
        // platform's default browser.
        .plugin(tauri_plugin_shell::init())

        // These handlers can be called from JavaScript.
        .invoke_handler(tauri::generate_handler![unlock_achievement])

        .setup(|app| {
            // Open dev tools in dev builds only.
            #[cfg(dev)]
            {
                let window = app.get_webview_window("main").unwrap();
                window.open_devtools();
            }
            Ok(())
        })

        .run(tauri::generate_context!("tauri.conf.json"))
        .expect("error while running tauri application");
}
