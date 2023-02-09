module "local_file_debug" {
  source   = "../../../templates/local/local_file"
  content  = "timestamp=${timestamp()}"
  filename = "debug.txt"
}

module "write_files_debug" {
  source = "../../../templates/local/write_files"
  files  = { "debug.txt" = "timestamp=${timestamp}" }
}