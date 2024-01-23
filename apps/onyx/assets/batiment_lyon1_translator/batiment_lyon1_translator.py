import json
import os
from translatepy import Translator
from tqdm import tqdm

arb_dir = '../../lib/l10n'
arb_files = [f for f in os.listdir(arb_dir) if f.endswith('.arb')]
languages = []
# Iterate over each .arb file
for arb_file in arb_files:
    languages.append(arb_file.split('_')[1].split('.')[0])

languages.remove('fr')
# Print the list of languages
print("Languages: ", languages)


# Load the JSON data
with open('../batiment_lyon1.json', 'r') as f:
    data = json.load(f)

# Iterate over each item in the data
for item in tqdm(data, desc="Translating"):
    # Get the French name
    fr_name = item['name']['fr']

    # Translate the name to each language
    for lang in languages:
        translator = Translator()
        translation = translator.translate(fr_name, lang, "fr").result

        # Add the translation to the item
        item['name'][lang] = translation

# Save the data back to the JSON file
with open('../batiment_lyon1_translated.json', 'w') as f:
    json.dump(data, f, ensure_ascii=False, indent=4)