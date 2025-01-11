FROM python:3.9-slim

# Set the working directory

WORKDIR /chatbot

# Copy the current directory contents into the container at /chatbot

COPY . /chatbot

RUN pip install -r requirements.txt

CMD ["python", "app.py"]




