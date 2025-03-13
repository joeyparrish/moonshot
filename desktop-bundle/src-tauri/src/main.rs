// Prevents additional console window on Windows in release, DO NOT REMOVE!!
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use tauri::Manager;

fn main() {
  tauri::Builder::default()
    /* Uncomment for debugging
    .setup(|app| {
      {
        let window = app.get_webview_window("main").unwrap();
        window.open_devtools();
      }
      Ok(())
    })
    // */
    .run(tauri::generate_context!("tauri.conf.json"))
    .expect("error while running tauri application");
}
