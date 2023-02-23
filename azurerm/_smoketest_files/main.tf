module "local_file_debug" {
  source   = "../../local/local_file"
  content  = "timestamp=${timestamp()}"
  filename = "debug.txt"
}

module "write_files_debug" {
  source = "../../local/write_files"
  files  = { "debug.txt" = "timestamp=${timestamp}" }
}