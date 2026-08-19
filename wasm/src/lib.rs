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
    let slug = std::str::from_utf8(slug).map_err(|e| e.to_string())?;
    let color = std::str::from_utf8(color).map_err(|e| e.to_string())?;
    let icon = simpleicons_rs::slug(slug).ok_or_else(|| "No available Icon".to_string())?;
    let color = if color == "default" {
        icon.hex
    } else {
        &csscolorparser::parse(color)
            .map_err(|e| e.to_string())?
            .to_css_hex()
    };

    Ok(icon
        .svg
        .replace("<svg", &format!("<svg fill=\"#{}\"", color))
        .into_bytes())
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
