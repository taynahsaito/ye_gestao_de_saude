from pdf2image import convert_from_path
import numpy as np
import pandas as pd
import pytesseract
import fitz  # PyMuPDF, imported as fitz for backward compatibility reasons
from PIL import Image
import cv2
import os.path
import random


pytesseract.pytesseract.tesseract_cmd = r"C:\Users\bonil\AppData\Local\Programs\Tesseract-OCR\tesseract.exe"

#backend
#passa o pdf para imagem
def pdf_to_img(pdf_file):
    imagens = []
    doc = fitz.open(pdf_file) #abre o documento
    for i, page in enumerate(doc):
        pix = page.get_pixmap()  #renderiza a página como imagem
        pix.save(f"page_{i}.png") #salva a imagem
        imagem = f"page_{i}.png"
        imagens.append(imagem) #adiciona o endereço da imagem na lista
        return imagem #vai retornar a lista com as imagens, mas até eu fazer isso, vai retornar so uma imagem

#realiza a ocr na imagem passada como parâmetro e retorna o texto extraído no formato de uma string.
def extract_text_from_image(img_name):
    # abre o caminho da imagem
    # image = Image.open(img_name)
    image = cv2.imread(img_name)


    #redefine o tamanho da imagem se ela for muito pequena
    height, width = image.shape[:2]

    if width < 5000 or height < 6000 :
        scale_width = 3000/ width
        scale_height = 4000/height
        scale = max(scale_width, scale_height)

        new_width = int(width * scale)
        new_height = int(height * scale)

        resized_image = cv2.resize(image, (new_width, new_height), interpolation=cv2.INTER_LINEAR)

    text = pytesseract.image_to_string(resized_image)
    return text


def escanear_exame(pdf_file):
    extracao = []
    img_name = pdf_to_img(pdf_file)
    text = extract_text_from_image(img_name)
    extracao.append(text)
    return extracao

def foto_exame():
    cam = cv2.VideoCapture(0)
    cv2.namedWindow("test")
    img_name = ""

    control = True
    while control:
        ret, frame = cam.read()
        if not ret:
            print("failed to grab frame")
            control = False
        cv2.imshow("test", frame)

        k = cv2.waitKey(1)
        if k%256 == 27:
            # ESC pressed
            print("Escape hit, closing...")
            control = False

        elif k%256 == 32:
            # SPACE pressed
            img_name = "opencv_frame_{}.png".format(random.randint(4, 1000))
            while os.path.isfile(img_name):
                img_name = "opencv_frame_{}.png".format(random.randint(5, 1000))
            cv2.imwrite(img_name, frame)
            print("{} written!".format(img_name))
            control = False

    cam.release()
    cv2.destroyAllWindows()
    text = extract_text_from_image(img_name)
    print(text)
    return text
