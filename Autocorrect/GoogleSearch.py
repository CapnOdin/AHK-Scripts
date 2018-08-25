import requests, re, sys

def GoogleSearch(term):
	try:
		s = requests.Session()
		search = "https://www.google.com/search?q=" + term
		response = s.get(search)
		
		res = re.search('id="resultStats".*?</a>', response.text).group(0)
		res = res[res.find("<a"):]
		res = re.search('(?<=">).*(?=</a>)', res).group(0)
		res = re.sub("</?(b|i)>", "", res)
	except:
		res = term
	return res

print(GoogleSearch(sys.argv[1]), end = "")