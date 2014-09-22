inbox_path '/Users/najlen/Dropbox/scans'

sort_rule 'Work' do
	match_strings "CompanyName"
	target_folder 'work'
end

sort_rule 'Tax papers' do
	match_strings "tax, irs"
	target_folder 'tax_papers'
end

sort_rule 'Mortgage' do
	match_strings "acme bank, interest"
	target_folder 'house'
end
