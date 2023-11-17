extends Node


const KANA_MOREBACKUPS_DIR := "KANA-MoreBackups"
const KANA_MOREBACKUPS_LOG_NAME := "KANA-MoreBackups"

var mod_dir_path := ""
var extensions_dir_path := ""
var translations_dir_path := ""


func _init(modLoader = ModLoader) -> void:
	mod_dir_path = ModLoaderMod.get_unpacked_dir().plus_file(KANA_MOREBACKUPS_DIR)
	# Add extensions
	install_script_extensions()
	# Add translations
	add_translations()


func install_script_extensions() -> void:
	extensions_dir_path = mod_dir_path.plus_file("extensions")
	ModLoaderMod.install_script_extension("res://mods-unpacked/KANA-MoreBackups/extensions/singletons/progress_data.gd")


func add_translations() -> void:
	translations_dir_path = mod_dir_path.plus_file("translations")
