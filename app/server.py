from flask import Flask, request, jsonify
from PIL import Image
import pytesseract
from googletrans import Translator

app = Flask(__name__)
translator = Translator()

def divide_text(text, chunk_size=500):
    """
    Divide the input text into chunks of specified size.
    """
    return [text[i:i+chunk_size] for i in range(0, len(text), chunk_size)]

@app.route('/detect_text', methods=['POST'])
def detect_text():
    if 'image' not in request.files:
        return jsonify({'error': 'No image provided'}), 400

    image = request.files['image']

    pytesseract.pytesseract.tesseract_cmd = r'C:/Program Files/Tesseract-OCR/tesseract.exe'
    # Use pytesseract to extract text from the image
    text = pytesseract.image_to_string(Image.open(image), lang='eng+hin')

    # Divide the text into chunks
    text_chunks = divide_text(text)

    # Translate each chunk and concatenate the results
    translated_text = ''
    for chunk in text_chunks:
        translated_chunk = translator.translate(chunk, dest='english').text
        translated_text += translated_chunk + ' '

    return jsonify({'text': text, 'translated_text': translated_text})

if __name__ == '__main__':
    app.run(host='192.168.1.7', debug=True)
