
# Bill Positions -------

function bill_positions(auth::Auth, jurisdiction, session, prefix, number; query = Dict(), options...)
	authentiate_query(query, auth)
	merge!(query, {
		"jurisdiction" => jurisdiction,
		"session" => session,
		"prefix" => prefix,
		"number" => number
		})

	r = get(URI(MAPLIGHT_API; path = "/services_open_api/map.bill_positions_v1.json");
            query = query,
            options...)
	
	handle_error(r)

	JSON.parse(r.data)
end

# -------