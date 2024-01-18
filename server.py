from flask import Flask, request, jsonify, send_file
from PIL import Image
import pytesseract
from googletrans import Translator
from huggingface_hub import InferenceClient
import re
import jinja2
import pdfkit
from datetime import datetime

app = Flask(__name__)
translator = Translator()

client = InferenceClient("mistralai/Mixtral-8x7B-Instruct-v0.1")

def format_prompt(message):
    system_prompt = "You are a professional lawyer and expert in Indian Penal Code(IPC) Sections. Give the applicable IPC sections for the following scenario. The IPC sections should be in list form: "
    prompt = f"<s>[SYS] {system_prompt} [/SYS]"

    prompt += f"[INST] {message} [/INST]"
    return prompt


def generate(
    prompt,temperature=0.2, max_new_tokens=256, top_p=0.95, repetition_penalty=1.0,
):
    temperature = float(temperature)
    if temperature < 1e-2:
        temperature = 1e-2
    top_p = float(top_p)

    generate_kwargs = dict(
        temperature=temperature,
        max_new_tokens=max_new_tokens,
        top_p=top_p,
        repetition_penalty=repetition_penalty,
        do_sample=True,
        seed=42,
    )

    formatted_prompt = format_prompt(prompt)

    stream = client.text_generation(formatted_prompt, **generate_kwargs, stream=True, details=True, return_full_text=False)
    output = ""

    for response in stream:
        output += response.token.text
        # yield output
    
    # print(output)
        
    # Using regex to find all occurrences of "Section XYZ"
    ipc_sections = re.findall(r'Section \d+[A-Z]*', output)
    
    return ipc_sections

def divide_text(text, chunk_size=500):
    return [text[i:i+chunk_size] for i in range(0, len(text), chunk_size)]

@app.route('/detect_text', methods=['POST'])
def detect_text():
    if 'image' not in request.files:
        return jsonify({'error': 'No image provided'}), 400

    image = request.files['image']

    pytesseract.pytesseract.tesseract_cmd = r'C:/Program Files/Tesseract-OCR/tesseract.exe'
    text = pytesseract.image_to_string(Image.open(image), lang='eng+hin')

    # Divide the text into chunks
    text_chunks = divide_text(text)

    # Translate each chunk and concatenate the results
    translated_text = ''
    for chunk in text_chunks:
        translated_chunk = translator.translate(chunk, dest='english').text
        translated_text += translated_chunk + ' '
        
    ipc_section = generate(translated_text)

    return jsonify({'text': translated_text, 'ipc_section': ipc_section})

@app.route('/generate_pdf', methods=['POST'])
def generate_pdf():
    # Get data from the request
    data = request.json

    # Update context with data received
    context = {
        'my_name': data['my_name'],
        'dist': data['dist'],
        'ps': data['ps'],
        'year': data['year'],
        'firno': data['firno'],
        'date': data['date'],
        'section1': data['section1'],
        'section2': data['section2'],
        'section3': data['section3'],
        'othersec': data['othersec'],
        'OOdate': data['OOdate'],
        'OOtime': data['OOtime'],
        'psdate': data['psdate'],
        'pstime': data['pstime'],
        'address': data['address'],
        'fathername': data['fathername'],
        'DOB': data['DOB'],
        'nationality': data['nationality'],
        'occupation': data['occupation'],
        'detailsofknownsus': data['detailsofknownsus'],
        'Desofcrime': data['Desofcrime'],
        'officername': data['officername'],
        'officerank': data['officerank'],
        'today_date': datetime.today().strftime("%d %b, %Y"),
    }

    # Render HTML template
    template_loader = jinja2.FileSystemLoader('template.html')  # Update this path to the location of your HTML template
    template_env = jinja2.Environment(loader=template_loader)
    
    html_template = 'template.html'
    template = template_env.get_template(html_template)
    output_text = template.render(context)

    # Generate PDF
    config = pdfkit.configuration(wkhtmltopdf="C:/Program Files/wkhtmltopdf/bin/wkhtmltopdf.exe")  # Update this path to the location of wkhtmltopdf
    output_pdf = f'{data["firno"]}.pdf'
    pdfkit.from_string(output_text, output_pdf, configuration=config)

    return send_file(output_pdf, as_attachment=True)

if __name__ == '__main__':
    app.run(host='10.255.2.10', debug=True)
