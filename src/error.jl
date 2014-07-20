
function handle_error(r::Response)
    r.status == 403 && error("403 Forbidden request to MapLight API - Probably you need an authentication key")
    r.status != 200 && error("Error querying MapLight API: $(r.status)")

    r.data == "\"Missing required arguments.\"" && error("Missing required arguments in MapLight API request")
end
