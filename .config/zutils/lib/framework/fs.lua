local FS = {}

function FS.exists(path)
	local ok, err, code = os.rename(path, path)
	if not ok then
		if code == 13 then
			-- Permission denied, but it exists
			return true
		end
	end
	return ok, err
end

function FS.delete_dir(path)
	-- FIX: Delete parent plugin folder if empty, possibly recursive because of sparse checkout
	os.execute("rm -Rf " .. path)
end

return FS
