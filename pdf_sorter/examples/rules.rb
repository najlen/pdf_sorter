inbox_path '/Users/najlen/docSync/projekt/PDF sorter/inbox'

sort_rule 'Företag' do
	match_strings "GrandTotal"
	target_folder 'företag'
end

sort_rule 'Skattepapper' do
	match_strings "skatt, rsv"
	target_folder 'skattepapper'
end

sort_rule 'Sbab' do
	match_strings "BÄTTRE BOLÅN"
	target_folder 'bolån'
end
