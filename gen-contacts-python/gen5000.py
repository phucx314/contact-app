from faker import Faker
import random
import json

fake = Faker()

# Danh sách các enum từ schema
phone_labels = ['Home', 'Work', 'Mobile', 'Other']
email_labels = ['Personal', 'Work', 'Study', 'Other']
social_labels = ['Facebook', 'X', 'Instagram', 'LinkedIn', 'Snapchat', 
                'TikTok', 'Pinterest', 'Reddit', 'YouTube', 'WhatsApp', 
                'WeChat', 'Zalo', 'Other']
address_labels = ['Home', 'Family home', 'Rental', 'Other']
contact_labels = ['Family', 'Friend', 'Neighborhood', 'Work', 'Other']

social_domains = {
    'Facebook': 'facebook.com',
    'X': 'x.com',
    'Instagram': 'instagram.com',
    'LinkedIn': 'linkedin.com',
    'Snapchat': 'snapchat.com',
    'TikTok': 'tiktok.com',
    'Pinterest': 'pinterest.com',
    'Reddit': 'reddit.com',
    'YouTube': 'youtube.com',
    'WhatsApp': 'whatsapp.com',
    'WeChat': 'wechat.com',
    'Zalo': 'zalo.me',
    'Other': 'example.com'
}

def generate_contact():
    contact = {
        'name': fake.name(),
        'isFavorite': fake.boolean(chance_of_getting_true=20),
        'phoneNumbers': [],
        'emails': [],
        'socialNetworks': [],
        'homeAddresses': [],
        'labels': [],
        'tags': []
    }

    # Avatar - 30% có dữ liệu
    if random.random() < 0.3:
        contact['avatar'] = fake.image_url()

    # Description - 50% có dữ liệu
    if random.random() < 0.5:
        contact['description'] = fake.sentence()

    # Số điện thoại (0-3 số)
    for _ in range(random.randint(0, 3)):
        contact['phoneNumbers'].append({
            'number': fake.phone_number(),
            'label': random.choice(phone_labels)
        })

    # Email (0-2 email)
    for _ in range(random.randint(0, 2)):
        contact['emails'].append({
            'email': fake.email(),
            'label': random.choice(email_labels)
        })

    # Ngày sinh - 70% có dữ liệu
    if random.random() < 0.7:
        contact['birthday'] = fake.date_of_birth(minimum_age=18, maximum_age=100).isoformat()

    # Mạng xã hội (0-4 tài khoản)
    for _ in range(random.randint(0, 4)):
        label = random.choice(social_labels)
        if label == 'Other':
            url = fake.url()
        else:
            url = f"https://{social_domains[label]}/{fake.user_name()}"
        contact['socialNetworks'].append({
            'socialNetwork': url,
            'label': label
        })

    # Địa chỉ nhà (0-2 địa chỉ)
    for _ in range(random.randint(0, 2)):
        contact['homeAddresses'].append({
            'address': fake.street_address(),
            'label': random.choice(address_labels)
        })

    # Labels (1-3 labels)
    contact['labels'] = random.sample(contact_labels, k=random.randint(1, 3))

    # Tags (0-5 tags ngẫu nhiên)
    contact['tags'] = fake.words(nb=random.randint(0, 5), unique=True)

    return contact

# Tạo 5000 contacts
contacts = [generate_contact() for _ in range(5000)]

# Lưu vào file JSON
with open('contacts.json', 'w') as f:
    json.dump(contacts, f, indent=2, ensure_ascii=False)

print("Đã tạo xong 5000 contacts và lưu vào file contacts.json")