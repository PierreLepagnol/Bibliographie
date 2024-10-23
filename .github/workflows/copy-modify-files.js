const fs = require("fs");
const path = require("path");
const glob = require("glob");

// Source and destination branch folder (default is root directory)
const sourceDir = "./";
const destDir = "./";

// Recursively copy files and modify them
glob(`${sourceDir}**/*.md`, (err, files) => {
    if (err) {
        console.error("Error finding .md files:", err);
        process.exit(1);
    }

    files.forEach((file) => {
        const fileName = path.basename(file, ".md");
        const newFilePath = path.join(destDir, file.replace(".md", ".qmd"));

        // Read the content of the .md file
        const content = fs.readFileSync(file, "utf8");

        // Add header
        const header = `---\ntitle: ${fileName}\n---\n\n`;
        const newContent = header + content;

        // Write the new .qmd file
        fs.writeFileSync(newFilePath, newContent, "utf8");
        console.log(`Converted ${file} to ${newFilePath}`);
    });
});
