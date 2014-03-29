-- Define a conky_escape function to aid in escaping any fields that may not
-- play well with JSON.
--
-- So far that means escape double quotes

function conky_json_escape(str)
    return conky_parse(str):gsub('"', '\\"')
end
