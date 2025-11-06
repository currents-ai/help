# Video to Documentation Workflow

Quick workflow to generate documentation from screen recordings using AI and ffmpeg.

## Prerequisites

```bash
# Install ffmpeg (one-time setup)
sudo apt-get install ffmpeg  # Linux
brew install ffmpeg          # macOS
```

## Complete Workflow (5 minutes)

### 1. Record Screen (2 min)
- Record your feature demo in MP4 format (1080p recommended)
- Go slowly, pause on important screens
- Save as `feature-name.mp4`

### 2. Generate Documentation with AI (2 min)

1. Go to [Google AI Studio](https://aistudio.google.com/)
2. Upload your video
3. Use this prompt (replace CATEGORY and FEATURE):

```
Analyze this screen recording and create step-by-step documentation in proper Markdown format.

Requirements:
- Title (# heading)
- Overview section (2-3 sentences)
- Prerequisites section (bulleted list)
- Steps section with:
  - Each step as ### heading
  - Timestamp in bold: **Timestamp: MM:SS**
  - 2-3 sentences explaining the step
  - Image placeholder: ![Step description](/img/help/CATEGORY/FEATURE/step-X.png)
- At the end, add "## FFmpeg Commands" section with commands to extract each image

Details:
CATEGORY: [reports/account/data-sources/guides/platform]
FEATURE: [feature-name-in-kebab-case]

Example: /img/help/reports/custom-reports/step-1.png
```

4. Copy the generated markdown

### 3. Save Documentation (30 sec)

```bash
# Save the doc in appropriate folder
vim help/[CATEGORY]/[FEATURE].md
# Paste AI-generated content, save and quit
```

### 4. Extract Images (2 min)

```bash
# Create image directory
mkdir -p static/img/help/[CATEGORY]/[FEATURE]
cd static/img/help/[CATEGORY]/[FEATURE]

# Copy video here
cp ~/Videos/feature-name.mp4 ./input.mp4

# Run ffmpeg commands (AI generated these at the end of the doc)
ffmpeg -ss 00:00:15 -i input.mp4 -frames:v 1 -q:v 2 step-1.png
ffmpeg -ss 00:00:28 -i input.mp4 -frames:v 1 -q:v 2 step-2.png
ffmpeg -ss 00:00:45 -i input.mp4 -frames:v 1 -q:v 2 step-3.png
# ... continue for all steps
```

### 5. Test & Commit (30 sec)

```bash
# Test locally
npm start

# Commit
git add help/[CATEGORY]/[FEATURE].md
git add static/img/help/[CATEGORY]/[FEATURE]/
git commit -m "docs: add [feature name] guide"
git push
```

## Project Structure

```
help/
├── account/           → static/img/help/account/
├── reports/           → static/img/help/reports/
├── data-sources/      → static/img/help/data-sources/
├── guides/            → static/img/help/guides/
└── platform/          → static/img/help/platform/
```

**Markdown path:** `/img/help/category/feature/step-X.png`
**File location:** `static/img/help/category/feature/step-X.png`

## Helper Script (Optional)

For batch extraction, create `timestamps.txt`:
```
00:15 step-1.png
00:28 step-2.png
00:45 step-3.png
```

Then run:
```bash
bash .docs-workflow/extract-images.sh video.mp4 static/img/help/CATEGORY/FEATURE timestamps.txt
```

## Quick Tips

**Recording:**
- Use 1080p resolution
- Close unnecessary tabs
- Use professional demo data
- Keep video 5-10 minutes

**AI Prompt:**
- Always specify CATEGORY and FEATURE
- Mention if there are specific UI elements to focus on
- Ask for troubleshooting section if needed

**Images:**
- Extract at stable UI moments (not mid-animation)
- Re-extract with `-y` flag if timestamp is wrong: `ffmpeg -ss 00:00:17 -i input.mp4 -frames:v 1 -q:v 2 step-1.png -y`
- Optimize: `optipng -o2 *.png`

## FFmpeg Parameters

- `-ss HH:MM:SS` - Timestamp to extract
- `-i file.mp4` - Input video
- `-frames:v 1` - Extract one frame
- `-q:v 2` - High quality (2-8 recommended)
- `-y` - Overwrite without asking

## Troubleshooting

**Images not showing?**
- Path must start with `/img/` not `/static/img/`
- Check file exists: `ls static/img/help/category/feature/step-X.png`

**Wrong frame captured?**
- Adjust timestamp ±1-2 seconds and re-run with `-y`

**Large file sizes?**
- Use `optipng -o2 *.png` or lower quality: `-q:v 5`
