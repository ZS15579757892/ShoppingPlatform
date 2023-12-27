with open('admin.txt', 'r') as file:
    lines = file.readlines()
    for line in lines:
        if "key_id" in line:
            key_id = line.split('=')[1]
        if "key_secret" in line:
            key_secret = line.split('=')[1]
print(key_id, key_secret)
