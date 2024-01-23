import json
from translatepy import Translator
from translatepy.translators.google import GoogleTranslate

# Load the original JSON file
with open('app_fr.arb', 'r') as file:
    data = json.load(file)

# Initialize Translator
translator = GoogleTranslate()

# Translate the values using translatepy
translated_data = {}
for key, value in data.items():
    # Make a translation request to translatepy
    translation = translator.translate(value, "Arabic")
    print(value)

    # Parse the translated response
    translated_value = translation.result
    translated_data[key] = translated_value

# Write the translated data to a new file
with open('app_ar.arb', 'w') as file:
    json.dump(translated_data, file, ensure_ascii=False, indent=4)