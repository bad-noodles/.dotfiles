local Output = {}

function Output.print(msg)
  print(msg)
end

function Output.print_human(msg)
  print(msg)
end

function Output.exit(code, message)
  io.stderr:write(message .. "\n")
  os.exit(code)
end

Output["error_codes"] = {
  BadUsage = 1,
  FailedToReadFile = 2,
  AlreadyInstalled = 3,
  NotInstalled = 4,
  ListedButNotInstalled = 5,
}

return Output
