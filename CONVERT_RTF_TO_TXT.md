# How to Convert RTF Files to Plain Text (.txt)

## Method 1: Using macOS TextEdit (Easiest)

1. **Open the RTF file** in TextEdit (double-click it)
2. **Select All** (Cmd+A)
3. **Copy** (Cmd+C)
4. **File → New** (Cmd+N) to create a new document
5. **Paste** (Cmd+V)
6. **File → Save** (Cmd+S)
7. **In the save dialog:**
   - Change format to "Plain Text" (not Rich Text)
   - Save as `.txt` file (e.g., `M05 Exam - 2021.txt`)
   - Save to the `exam_papers/` folder

## Method 2: Using Command Line (Terminal)

### Option A: Using `textutil` (Built-in macOS tool)

```bash
cd /Users/aaronpearsall/m05/exam_papers

# Convert each RTF file to TXT
textutil -convert txt "M05 Exam - 2021.rtf" -output "M05 Exam - 2021.txt"
textutil -convert txt "M05 Exam - 2022.rtf" -output "M05 Exam - 2022.txt"
textutil -convert txt "M05 Exam - 2023.rtf" -output "M05 Exam - 2023.txt"
textutil -convert txt "M05 Exam - 2024.rtf" -output "M05 Exam - 2024.txt"
textutil -convert txt "M05 Exam - 2025.rtf" -output "M05 Exam - 2025.txt"
```

### Option B: Convert all RTF files at once

```bash
cd /Users/aaronpearsall/m05/exam_papers

# Convert all RTF files to TXT
for file in *.rtf; do
    if [ -f "$file" ]; then
        filename="${file%.rtf}"
        textutil -convert txt "$file" -output "${filename}.txt"
        echo "Converted: $file → ${filename}.txt"
    fi
done
```

### Option C: Using Python (if you have it installed)

```bash
cd /Users/aaronpearsall/m05/exam_papers

python3 << 'EOF'
import re
from pathlib import Path

# Simple RTF to text converter (removes RTF codes)
def rtf_to_text(rtf_content):
    # Remove RTF control words and groups
    text = re.sub(r'\{[^}]*\}', '', rtf_content)
    # Remove RTF commands
    text = re.sub(r'\\[a-z]+\d*\s?', '', text)
    # Remove extra whitespace
    text = re.sub(r'\s+', ' ', text)
    # Restore line breaks
    text = text.replace('\\par', '\n')
    text = text.replace('\\line', '\n')
    return text.strip()

# Convert all RTF files
for rtf_file in Path('.').glob('*.rtf'):
    txt_file = rtf_file.with_suffix('.txt')
    with open(rtf_file, 'r', encoding='utf-8', errors='ignore') as f:
        rtf_content = f.read()
    text_content = rtf_to_text(rtf_content)
    with open(txt_file, 'w', encoding='utf-8') as f:
        f.write(text_content)
    print(f"Converted: {rtf_file.name} → {txt_file.name}")
EOF
```

## Method 3: Using Online Converters

1. Go to an online RTF to TXT converter (e.g., https://convertio.co/rtf-txt/)
2. Upload your RTF file
3. Download the converted TXT file
4. Save it to the `exam_papers/` folder

## Method 4: Using Pandoc (If Installed)

If you have `pandoc` installed:

```bash
cd /Users/aaronpearsall/m05/exam_papers

pandoc "M05 Exam - 2021.rtf" -t plain -o "M05 Exam - 2021.txt"
```

## Recommended: Method 2 Option B (Command Line - All at Once)

The easiest way is to run this command in Terminal:

```bash
cd /Users/aaronpearsall/m05/exam_papers && for file in *.rtf; do if [ -f "$file" ]; then filename="${file%.rtf}"; textutil -convert txt "$file" -output "${filename}.txt"; echo "Converted: $file → ${filename}.txt"; fi; done
```

This will convert all RTF files in the `exam_papers/` folder to TXT files automatically.

## After Conversion

1. **Delete the RTF files** (optional, to keep things clean):
   ```bash
   cd /Users/aaronpearsall/m05/exam_papers
   rm *.rtf
   ```

2. **Verify the TXT files look correct** - open one in a text editor to make sure the formatting is clean

3. **Restart the app** or wait for Railway to redeploy - the app will automatically use the TXT files

## Tips

- **Check the output**: After conversion, open a TXT file to make sure questions and options are formatted correctly
- **Clean up formatting**: You may need to manually clean up some RTF artifacts (extra spaces, formatting codes)
- **Keep backups**: Keep the original RTF files until you've verified the TXT files work correctly

