import os
import subprocess
import threading
from tempfile import NamedTemporaryFile

# Streamlit app content
streamlit_code = """
import streamlit as st
from langchain.prompts import PromptTemplate
from dotenv import load_dotenv
from langchain_groq import ChatGroq

# Load environment variables
load_dotenv()

# Create a new prompt template
prompt = '''You are a helpful AI Assistant. Do best to answer user question in 50 words maximum.
Below is user question : {question}'''

prompt_template = PromptTemplate(
    template=prompt,
    input_variables=["question"]
)

# Create a new ChatGroq instance
llm = ChatGroq(temperature=0, model="llama3-70b-8192", max_tokens=50)

chain = prompt_template | llm

# Streamlit UI
def main():
    st.title("AI Assistant")

    # Input form
    question = st.text_input("Enter your question:")

    if st.button("Get Answer"):
        if question.strip():
            try:
                # Generate a response
                response = chain.invoke({"question": question})
                st.success(f"Answer: {response.content}")
            except Exception as e:
                st.error(f"Error: {str(e)}")
        else:
            st.warning("Please enter a question.")

if __name__ == "__main__":
    main()
"""

# Function to run Streamlit app in a separate thread
def run_streamlit():
    with NamedTemporaryFile(delete=False, suffix=".py") as temp_file:
        temp_file.write(streamlit_code.encode())
        temp_file.flush()
        try:
            subprocess.run(["streamlit", "run", temp_file.name])
        finally:
            os.unlink(temp_file.name)

if __name__ == "__main__":
    thread = threading.Thread(target=run_streamlit)
    thread.start()
    thread.join()
