import jinja2
import pdfkit
from datetime import datetime

my_name = "Frank Andrade"
dist = "TV"
ps = "Couch"
year = "Washing Machine"
firno = "Couch"
date = "Couch"
section1 = "Couch"
section2 = "Couch"
section3 = "Couch"
othersec = "Couch"
OOdate = "Couch"
OOtime = "Couch"
psdate = "Couch"
pstime = "Couch"
address = "Couch"
POOdistrict = "Couch"
fathername = "Couch"
DOB = "Couch"
nationality = "Couch"
detailsofknownsus = "Couch"
Desofcrime = "Couch"
officername = "Couch"
officerank = "Couch"

today_date = datetime.today().strftime("%d %b, %Y")

context = {
    'my_name': my_name,
    'dist': dist,
    'ps': ps,
    'year': year,
    'firno': firno,
    'date': date,
    'section1': section1,
    'section2': section2,
    'section3': section3,
    'othersec': othersec,
    'OOdate': OOdate,
    'OOtime': OOtime,
    'psdate': psdate,
    'pstime': pstime,
    'address': address,
    'POOdistrict': POOdistrict,
    'fathername': fathername,
    'DOB': DOB,
    'nationality': nationality,
    'detailsofknownsus': detailsofknownsus,
    'Desofcrime': Desofcrime,
    'officername': officername,
    'officerank': officerank,
    'today_date': today_date,
}

template_loader = jinja2.FileSystemLoader('./')  # Update this path to the location of your HTML template
template_env = jinja2.Environment(loader=template_loader)

html_template = 'template.html'
template = template_env.get_template(html_template)
output_text = template.render(context)

config = pdfkit.configuration(wkhtmltopdf="C:/Program Files/wkhtmltopdf/bin/wkhtmltopdf.exe")  # Update this path to the location of wkhtmltopdf
output_pdf = 'pdf_generated7.pdf'
pdfkit.from_string(output_text, output_pdf, configuration=config)
