# Get started

## 1. Set up virtual environment and activate it

```
    python3 -m venv .venv
    source .venv/bin/activate
```

## 2. Install requirements

```
    pip install -r requirements.txt
```

## 3. Create .env file.
Here you can store important information about your django and database secrets. Insert your data using following keys:

```
    # Django
    SECRET_KEY = *****
    ALLOWED_HOSTS = *****
    DEBUG = True

    # Database
    POSTGRES_NAME = ****
    POSTGRES_USER = ****
    POSTGRES_PASSWORD = ****
    POSTGRES_HOST = ****
    POSTGRES_PORT = ****

```
## 4. Apply migrations and create a superuser
```
    python3 manage.py makemigrations
    python3 manage.py migrate
    python3 manage.py createsuperuser
```

## 5. Launch the server
```
    cd stuff_helper
    python3 manage.py runserver
```
*Recommendations for usage*

Use Postman to send GET and POST requests correctly. It will save you a lot of time.