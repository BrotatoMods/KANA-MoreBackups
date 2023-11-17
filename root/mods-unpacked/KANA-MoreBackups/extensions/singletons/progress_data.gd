extends "res://singletons/progress_data.gd"


const KANA_MOREBACKUPS_LOG_NAME := "KANA-MoreBackups:ProgressData"
const KANA_BACKUP_FOLDER_PATH := "user://More_Backups/"


func init_save_paths() -> void:
	.init_save_paths()
	ModLoaderLog.info("Save File Path: %s" % SAVE_PATH, KANA_MOREBACKUPS_LOG_NAME)

	var backup_save_path := KANA_BACKUP_FOLDER_PATH.plus_file("save-%s.json" % ModLoaderLog._get_date_string())

	if not _ModLoaderFile.dir_exists(KANA_BACKUP_FOLDER_PATH):
		make_dir_recursive(KANA_BACKUP_FOLDER_PATH)
		ModLoaderLog.info("Created More Backups Directory at: '%s'" % KANA_BACKUP_FOLDER_PATH, KANA_MOREBACKUPS_LOG_NAME)

	if not _ModLoaderFile.file_exists(backup_save_path):
		file_copy(SAVE_PATH, backup_save_path)
		ModLoaderLog.info("New backup created at: '%s'" % backup_save_path, KANA_MOREBACKUPS_LOG_NAME)
	else:
		ModLoaderLog.debug("Backup from today exists already at: '%s'" % backup_save_path, KANA_MOREBACKUPS_LOG_NAME)


static func make_dir_recursive(dst_dir: String) -> bool:
	var dir := Directory.new()
	var error := dir.make_dir_recursive(dst_dir)
	if error != OK:
		ModLoaderLog.error("Failed creating directory at %s with error code %s" % [dst_dir, error], KANA_MOREBACKUPS_LOG_NAME)
		return false
	return true


# Copies a file from a given src to the specified dst path.
# src = path/to/file.extension
# dst = other/path/to/file.extension
static func file_copy(src: String, dst: String) -> void:
	var dir := Directory.new()
	var dst_dir := dst.get_base_dir()

	if not dir.dir_exists(dst_dir):
		dir.make_dir_recursive(dst_dir)

	dir.copy(src, dst)
