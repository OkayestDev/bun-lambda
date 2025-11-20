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
const COMPILE_CODE = args[5];

const DOCKERFILE_TEMPLATE_PATH = path.join(__dirname, "Dockerfile.template");

const COMPILE_BUILD = `RUN bun build --compile /var/task/${templates.LAMBDA_FUNCTION_HANDLER}  --outfile lambda`;
const COMPILE_COMMAND = `CMD ["/var/task/lambda"]`;

const TRANSPILE_COMMAND = `CMD ["bun", "run", "/var/task/${templates.LAMBDA_FUNCTION_HANDLER}"]`;

function templateDockerfile() {
  let templateFile = fs.readFileSync(DOCKERFILE_TEMPLATE_PATH, 'utf8');

  Object.keys(templates).forEach(template => {
    templateFile = templateFile.replaceAll(`{{${template}}}`, templates[template]);
  });

  if (COMPILE_CODE === "true") {
    templateFile = templateFile.replaceAll(`{{COMPILE}}`, COMPILE_BUILD);
    templateFile = templateFile.replaceAll(`{{COMMAND}}`, COMPILE_COMMAND);
    templateFile = templateFile.replaceAll(`{{BUN_INSTALL}}`, ``);
  } else {
    templateFile = templateFile.replaceAll(`{{COMPILE}}`, "");
    templateFile = templateFile.replaceAll(`{{COMMAND}}`, TRANSPILE_COMMAND);
    templateFile = templateFile.replaceAll(`{{BUN_INSTALL}}`, `COPY --from=bun_latest /usr/local/bin/bun /usr/local/bin/bun`);
  }


  const fileName = path.join(__dirname, `${FILE_NAME}.Dockerfile`);
  fs.writeFileSync(fileName, templateFile);
}

if (require.main === module) {
  templateDockerfile();
}
