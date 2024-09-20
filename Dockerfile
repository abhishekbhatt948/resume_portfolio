# Step 1: Use an official Python runtime as a parent image
FROM python:3.9

# Step 2: Set the working directory in the container
WORKDIR /app

# Step 3: Copy the requirements.txt file into the container
COPY requirements.txt .

# Step 4.1: Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Step 5: Copy the rest of the application code into the container
COPY . .

# Step 6: Expose the port on which the app runs (Flask usually runs on port 5000)
EXPOSE 5000

# Step 7: Define environment variables (optional, you can specify any environment variables needed)
ENV FLASK_APP=app.py
ENV FLASK_ENV=Dev

# Step 8: Run the application using Flask
CMD ["flask", "run", "--host=0.0.0.0"]
