#!/bin/bash
# Quick deploy script - commits and pushes changes to GitHub
# Railway will automatically redeploy when it detects the push

echo "🚀 Deploying to GitHub..."

# Add all changes
git add .

# Check if there are changes to commit
if git diff --staged --quiet; then
    echo "✅ No changes to commit"
    exit 0
fi

# Commit with timestamp
COMMIT_MSG="${1:-Update app files - $(date '+%Y-%m-%d %H:%M:%S')}"
git commit -m "$COMMIT_MSG"

# Push to GitHub
echo "📤 Pushing to GitHub..."
git push origin main

if [ $? -eq 0 ]; then
    echo "✅ Successfully pushed to GitHub!"
    echo "🔄 Railway will automatically redeploy in a few moments..."
    echo "💡 Check your Railway dashboard for deployment status"
else
    echo "❌ Failed to push. Check your git credentials."
    exit 1
fi

