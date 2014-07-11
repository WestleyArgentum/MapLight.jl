
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

# -------

function organization_positions(auth::Auth, jurisdiction, org_id; options...)
	maplight_get(auth, "/services_open_api/map.organization_positions_v1.json", {
		"jurisdiction" => jurisdiction,
		"organization_id" => org_id }; options...)
end

organization_positions(auth::String, jurisdiction, org_id; options...) = organization_positions(authenticate(auth), jurisdiction, org_id; options...)

organization_positions(jurisdiction, org_id; auth = authenticate(), options...) = organization_positions(auth, jurisdiction, org_id; options...)

# -------

function organization_search(auth::Auth, search_str, exact = 0; options...)
	maplight_get(auth, "/services_open_api/map.organization_search_v1.json", {
		"search" => search_str,
		"exact" => exact }; options...)
end

organization_search(auth::String, search_str, exact = 0; options...) = organization_search(authenticate(auth), search_str, exact; options...)

organization_search(search_str, exact = 0; auth = authenticate(), options...) = organization_search(auth, search_str, exact; options...)
