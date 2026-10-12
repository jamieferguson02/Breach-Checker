# use python as the base image
FROM python:3.13-slim

# make Python output unbuffered so logs appear in real time,
# and stop pip caching downloads inside the image
ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# set the working directory inside the container
WORKDIR /app

# copy the requirements file and install runtime dependencies only
COPY requirements.txt .
RUN pip install -r requirements.txt

# copy everything the app needs to run
# (the API key is NOT copied - pass it at runtime with --env-file .env)
COPY src/ ./src/
COPY config.yaml .
COPY email_list.csv .

# run as a non-root user to limit what the container can do
RUN useradd --create-home --uid 1000 appuser && chown -R appuser /app
USER appuser

# run the application
CMD ["python", "-m", "src.main"]
