
function maplight_get(auth::Auth, path, args; query = Dict(), options...)
	authentiate_query(query, auth)
	merge!(query, args)

	r = get(URI(MAPLIGHT_API; path = path); query = query, options...)

	handle_error(r)

	JSON.parse(r.data)
end

# -------

function bill_positions(auth::Auth, jurisdiction, session, prefix, number; options...)
	maplight_get(auth, "/services_open_api/map.bill_positions_v1.json", {
		"jurisdiction" => jurisdiction,
		"session" => session,
		"prefix" => prefix,
		"number" => number
		}; options...)
end

bill_positions(auth::String, jurisdiction, session, prefix, number; options...) = bill_positions(authenticate(auth), jurisdiction, session, prefix, number; options...)

bill_positions(jurisdiction, session, prefix, number; auth = authenticate(), options...) = bill_positions(auth, jurisdiction, session, prefix, number; options...)

# -------

function bill_search(auth::Auth, jurisdiction, search_str; options...)
	maplight_get(auth, "/services_open_api/map.bill_search_v1.json", { "jurisdiction" => jurisdiction, "search" => search_str }; options...)
end

bill_search(auth::String, jurisdiction, search_str; options...) = bill_search(authenticate(auth), jurisdiction, search_str; options...)

bill_search(jurisdiction, search_str; auth = authenticate(), options...) = bill_search(auth, jurisdiction, search_str; options...)
