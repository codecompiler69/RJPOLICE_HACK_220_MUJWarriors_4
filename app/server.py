from flask import Flask, request, jsonify
from PIL import Image
import pytesseract

app = Flask(__name__)

@app.route('/detect_text', methods=['POST'])
def detect_text():
    if 'image' not in request.files:
        return jsonify({'error': 'No image provided'}), 400

    image = request.files['image']

    pytesseract.pytesseract.tesseract_cmd = r'C:/Program Files/Tesseract-OCR/tesseract.exe'
    # Use pytesseract to extract text from the image
    text = pytesseract.image_to_string(Image.open(image), lang='eng+hin')

    return jsonify({'text': text})

if __name__ == '__main__':
    app.run(host='192.168.1.7',debug=True)
