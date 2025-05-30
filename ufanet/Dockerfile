FROM python:3.13.3-slim

ENV PYTHONBUFFERED=1

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY ./ /app

WORKDIR /app

RUN python manage.py collectstatic --noinput

CMD [ "python3", "manage.py", "runserver", "0.0.0.0:8000"]
