1. OS
2. Python
3. Code
4. Install Dependencies
5. Miscelleanous


source location and destination

COPY . /chatbot

CMD 1. What type of file 2. File name

CMD ["python","app.py]

# Step1 : Create Docker File

# Step 2: Create Image

1. Create Image : docker build -t chatbot .


# Step 3: Create Container

1. docker run -it -p 8001:8501 --env-file .env ac148c24811c

