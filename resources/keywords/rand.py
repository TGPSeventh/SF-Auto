import random
import string

def generate_random_name():
    first_names = ['Peale', 'Ces', 'Micheal', 'Jane', 'Gen', 'Berna']
    last_names = ['Normies', 'Casti', 'Orphi', 'Albay', 'Tri', 'Carver']
    return f"{random.choice(first_names)} {random.choice(last_names)}"

def generate_random_email():
    domains = ['example.com', 'testmail.com', 'mailinator.com', 'ram.com.au.invalid']
    # username = ''.join(random.choices(string.ascii_lowercase + string.digits, k=8))
    # return f"{username}@{random.choice(domains)}"
    full_name = generate_random_name()
    username = full_name.split()[0].lower()  # Take the first name and make it lowercase
    return f"{username}{random.randint(1, 99)}@{random.choice(domains)}"  # Add a random number to ensure uniqueness

def generate_random_password(length=10):
    chars = string.ascii_letters + string.digits + "!@#$%^&*()"
    return ''.join(random.choices(chars, k=length))