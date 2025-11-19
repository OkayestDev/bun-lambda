const fs = require('fs')
const path = require('path')

// CODE_PATH PACKAGE_JSON_PATH BUN_LOCK_PATH FILE_NAME
const args = process.argv.slice(2);
const templates = {
  CODE_PATH: args[0],
  PACKAGE_JSON_PATH: args[1],
  BUN_LOCK_PATH: args[2],
  LAMBDA_FUNCTION_HANDLER: args[3],
}
const FILE_NAME = args[4]

const DOCKERFILE_TEMPLATE_PATH = path.join(__dirname, "Dockerfile.template");

function templateDockerfile() {
  let templateFile = fs.readFileSync(DOCKERFILE_TEMPLATE_PATH, 'utf8');

  Object.keys(templates).forEach(template => {
    templateFile = templateFile.replaceAll(`{{${template}}}`, templates[template]);
  });

  const fileName = path.join(__dirname, `${FILE_NAME}.Dockerfile`);
  fs.writeFileSync(fileName, templateFile);
}

if (require.main === module) {
  templateDockerfile();
}
