#[cfg(target_arch = "wasm32")]
use wasm_minimal_protocol::wasm_func;

wasm_minimal_protocol::initiate_protocol!();

#[wasm_func]
#[cfg(target_arch = "wasm32")]
fn simple_icons_slug(slug: &[u8]) -> Result<Vec<u8>, String> {
    if let Some(icon) = simpleicons_rs::slug(std::str::from_utf8(slug).unwrap()) {
        Ok(icon.svg.as_bytes().to_vec())
    } else {
        Err("No available Icon".to_string())
    }
}

#[wasm_func]
#[cfg(target_arch = "wasm32")]
fn simple_icons_slug_colored(slug: &[u8], color: &[u8]) -> Result<Vec<u8>, String> {
    if let Some(icon) = simpleicons_rs::slug_colored(
        std::str::from_utf8(slug).unwrap(),
        std::str::from_utf8(color).unwrap(),
    ) {
        Ok(icon.svg.as_bytes().to_vec())
    } else {
        Err("No available Icon".to_string())
    }
}

#[wasm_func]
#[cfg(target_arch = "wasm32")]
fn simple_icons_title(slug: &[u8]) -> Result<Vec<u8>, String> {
    if let Some(icon) = simpleicons_rs::slug(std::str::from_utf8(slug).unwrap()) {
        Ok(icon.title.as_bytes().to_vec())
    } else {
        Err("No available Title".to_string())
    }
}

#[wasm_func]
#[cfg(target_arch = "wasm32")]
fn simple_icons_color(slug: &[u8]) -> Result<Vec<u8>, String> {
    if let Some(icon) = simpleicons_rs::slug(std::str::from_utf8(slug).unwrap()) {
        Ok(icon.hex.as_bytes().to_vec())
    } else {
        Err("No available Title".to_string())
    }
}
