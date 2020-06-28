// @ts-ignore
import {DokiThemeDefinitions, MasterDokiThemeDefinition, StringDictonary, VimDokiThemeDefinition} from './types';

const path = require('path');

const repoDirectory = path.resolve(__dirname, '..', '..');

const fs = require('fs');

const masterThemeDefinitionDirectoryPath =
  path.resolve(repoDirectory, 'masterThemes');

const colorDirectoryPath =
  path.resolve(repoDirectory, 'colors');

const afterDirectoryPath =
  path.resolve(repoDirectory, 'after');

const autoLoadDirectoryPath =
  path.resolve(repoDirectory, 'autoload');

const vimDefinitionDirectoryPath = path.resolve(
  '.',
  "themes",
  "definitions"
);

const vimScriptTemplateDirectoryPath = path.resolve(
  '.',
  "templates",
);

function walkDir(dir: string): Promise<string[]> {
  const values: Promise<string[]>[] = fs.readdirSync(dir)
    .map((file: string) => {
      const dirPath: string = path.join(dir, file);
      const isDirectory = fs.statSync(dirPath).isDirectory();
      if (isDirectory) {
        return walkDir(dirPath);
      } else {
        return Promise.resolve([path.join(dir, file)]);
      }
    });
  return Promise.all(values)
    .then((scannedDirectories) => scannedDirectories
      .reduce((accum, files) => accum.concat(files), []));
}

const LAF_TYPE = 'laf';
const SYNTAX_TYPE = 'syntax';
const NAMED_COLOR_TYPE = 'colorz';

function getTemplateType(templatePath: string) {
  if (templatePath.endsWith('laf.template.json')) {
    return LAF_TYPE;
  } else if (templatePath.endsWith('syntax.template.json')) {
    return SYNTAX_TYPE;
  } else if (templatePath.endsWith('colors.template.json')) {
    return NAMED_COLOR_TYPE;
  }
  return undefined;
}


function resolveTemplate<T, R>(
  childTemplate: T,
  templateNameToTemplate: StringDictonary<T>,
  attributeResolver: (t: T) => R,
  parentResolver: (t: T) => string,
): R {
  if (!parentResolver(childTemplate)) {
    return attributeResolver(childTemplate);
  } else {
    const parent = templateNameToTemplate[parentResolver(childTemplate)];
    const resolvedParent = resolveTemplate(
      parent,
      templateNameToTemplate,
      attributeResolver,
      parentResolver
    );
    return {
      ...resolvedParent,
      ...attributeResolver(childTemplate)
    };
  }
}


function resolveColor(
  color: string,
  namedColors: StringDictonary<string>
): string {
  const startingTemplateIndex = color.indexOf('&');
  if (startingTemplateIndex > -1) {
    const lastDelimiterIndex = color.lastIndexOf('&');
    const namedColor =
      color.substring(startingTemplateIndex + 1, lastDelimiterIndex);
    const namedColorValue = namedColors[namedColor];
    if (!namedColorValue) {
      throw new Error(`Named color: '${namedColor}' is not present!`);
    }

    // todo: check for cyclic references
    if (color === namedColorValue) {
      throw new Error(`Very Cheeky, you set ${namedColor} to resolve to itself 😒`);
    }

    const resolvedNamedColor = resolveColor(namedColorValue, namedColors);
    if (!resolvedNamedColor) {
      throw new Error(`Cannot find named color '${namedColor}'.`);
    }
    return resolvedNamedColor + color.substring(lastDelimiterIndex + 1) || '';
  }

  return color;
}

function applyNamedColors(
  objectWithNamedColors: StringDictonary<string>,
  namedColors: StringDictonary<string>,
): StringDictonary<string> {
  return Object.keys(objectWithNamedColors)
    .map(key => {
      const color = objectWithNamedColors[key];
      const resolvedColor = resolveColor(
        color,
        namedColors
      );
      return {
        key,
        value: resolvedColor
      };
    }).reduce((accum: StringDictonary<string>, kv) => {
      accum[kv.key] = kv.value;
      return accum;
    }, {});
}

function constructNamedColorTemplate(
  dokiThemeTemplateJson: MasterDokiThemeDefinition,
  dokiTemplateDefinitions: DokiThemeDefinitions
) {
  const lafTemplates = dokiTemplateDefinitions[NAMED_COLOR_TYPE];
  const lafTemplate =
    (dokiThemeTemplateJson.dark ?
      lafTemplates.dark : lafTemplates.light);

  const resolvedColorTemplate =
    resolveTemplate(
      lafTemplate, lafTemplates,
      template => template.colors,
      template => template.extends
    );

  const resolvedNameColors = resolveNamedColors(
    dokiTemplateDefinitions,
    dokiThemeTemplateJson
  );

  // do not really need to resolve, as there are no
  // &someName& colors, but what ever.
  const resolvedColors =
    applyNamedColors(resolvedColorTemplate, resolvedNameColors);
  return {
    ...resolvedColors,
    ...resolvedColorTemplate,
    ...resolvedNameColors,
  };
}

function resolveNamedColors(
  dokiTemplateDefinitions: DokiThemeDefinitions,
  dokiThemeTemplateJson: MasterDokiThemeDefinition
) {
  const colorTemplates = dokiTemplateDefinitions[NAMED_COLOR_TYPE];
  return resolveTemplate(
    dokiThemeTemplateJson,
    colorTemplates,
    template => template.colors,
    // @ts-ignore
    template => template.extends ||
      template.dark !== undefined && (dokiThemeTemplateJson.dark ?
        'dark' : 'light'));
}

export interface StringDictionary<T> {
  [key: string]: T;
}

export const dictionaryReducer = <T>(
  accum: StringDictionary<T>,
  [key, value]: [string, T],
) => {
  accum[key] = value;
  return accum;
};

function constructVimName(dokiTheme: MasterDokiThemeDefinition) {
  return dokiTheme.name.replace(/ /g, '_').toLowerCase();
}

function buildVimColorScript(
  dokiThemeDefinition: MasterDokiThemeDefinition,
  dokiTemplateDefinitions: DokiThemeDefinitions,
  dokiThemeVimDefinition: VimDokiThemeDefinition,
  vimColorScript: string,
) {
  return evaluateTemplate(
    dokiThemeDefinition,
    dokiTemplateDefinitions,
    vimColorScript
  );
}

function buildVimSyntaxScript(
  dokiThemeDefinition: MasterDokiThemeDefinition,
  dokiTemplateDefinitions: DokiThemeDefinitions,
  dokiThemeVimDefinition: VimDokiThemeDefinition,
  vimAfterScript: FileDef[],
) {
  return vimAfterScript.map(({fileName, fileContents})=>({
    fileName,
    fileContents: evaluateTemplate(
      dokiThemeDefinition,
      dokiTemplateDefinitions,
      fileContents
    )
  }));
}


function buildVimAfterScript(
  dokiThemeDefinition: MasterDokiThemeDefinition,
  dokiTemplateDefinitions: DokiThemeDefinitions,
  dokiThemeVimDefinition: VimDokiThemeDefinition,
  vimAfterScript: string,
) {
  return evaluateTemplate(
    dokiThemeDefinition,
    dokiTemplateDefinitions,
    vimAfterScript
  );
}

function buildVimAutoLoadScript(
  dokiThemeDefinition: MasterDokiThemeDefinition,
  dokiTemplateDefinitions: DokiThemeDefinitions,
  dokiThemeVimDefinition: VimDokiThemeDefinition,
  vimAutoLoadScript: string,
) {
  return evaluateTemplate(
    dokiThemeDefinition,
    dokiTemplateDefinitions,
    vimAutoLoadScript
  );
}

const capitalize = require('lodash/capitalize');

function evaluateTemplate(
  dokiThemeDefinition: MasterDokiThemeDefinition,
  dokiTemplateDefinitions: DokiThemeDefinitions,
  vimAutoLoadScript: string,
) {
  const namedColors = constructNamedColorTemplate(
    dokiThemeDefinition, dokiTemplateDefinitions,
  );
  const themeName = constructVimName(dokiThemeDefinition);
  const themeProperName = dokiThemeDefinition.name.split(" ")
    .map(part => capitalize(part))
    .join('')

  try {
    return fillInTemplateScript(
      vimAutoLoadScript,
      {
        ...namedColors,
        themeName,
        themeProperName,
      }
    );
  } catch (e) {
    throw Error(`Unable to evaluate ${dokiThemeDefinition.name}'s template for raisins: ${e.message}.`);
  }
}

function getColorFromTemplate(templateVariables: StringDictionary<string>, templateVariable: string) {
  const resolvedTemplateVariable = templateVariables[templateVariable];
  if (!resolvedTemplateVariable) {
    throw Error(`Template does not have variable ${templateVariable}`)
  }

  return resolvedTemplateVariable;
}

function toRGBArray(hexColor: string): number[] {
  const hexNumber = parseInt(hexColor.substr(1), 16);
  return [
    (hexNumber & 0xFF0000) >> 16,
    (hexNumber & 0XFF00) >> 8,
    hexNumber & 0xFF
  ]
}

type X256Color = { rgbArray: number[]; name: string; guifg: string; ctermfg: number };
const x256Colors = require('./XTerm256Colors').default;
const x256ColorsWithRGB: X256Color[] = x256Colors.map((c: { name: string; guifg: string; ctermfg: number }) => ({
  ...c,
  rgbArray: toRGBArray(c.guifg)
}))

function findClosestX256Color(hexColor: string): string {
  const themeColor = toRGBArray(hexColor);
  const closest = x256ColorsWithRGB.reduce((accum,
                                            next: X256Color) => {
    const distance = themeColor.map((number, index) => Math.abs(number - next.rgbArray[index]))
      .reduce((accum, next) => accum + next, 0)
    if (distance < accum.distance) {
      accum.distance = distance;
      accum.closest = next
    }
    return accum;
  }, {
    closest: x256ColorsWithRGB[0],
    distance: Number.MAX_VALUE
  });
  return closest.closest.ctermfg.toString();
}

const x256Delimiter = '$x256';

function resolveTemplateVariable(
  templateVariable: string,
  templateVariables: StringDictionary<string>,
): string {
  if (templateVariable.endsWith(x256Delimiter)) {
    const colorFromTemplate = resolveColor(getColorFromTemplate(
      templateVariables,
      templateVariable.substr(0, templateVariable.length - x256Delimiter.length)
    ), templateVariables);
    return findClosestX256Color(colorFromTemplate)
  }
  return resolveColor(getColorFromTemplate(templateVariables, templateVariable), templateVariables);
}

function fillInTemplateScript(
  templateToFillIn: string,
  templateVariables: StringDictionary<string>,
) {
  return templateToFillIn.split('\n')
    .map(line => {
      const reduce = line.split("").reduce((accum, next) => {
        if (accum.currentTemplate) {
          if (next === '}' && accum.currentTemplate.endsWith('}')) {
            // evaluate Template
            const templateVariable = accum.currentTemplate.substring(2, accum.currentTemplate.length - 1)
            accum.currentTemplate = ''
            const resolvedTemplateVariable = resolveTemplateVariable(
              templateVariable,
              templateVariables
            )
            accum.line += resolvedTemplateVariable
          } else {
            accum.currentTemplate += next
          }
        } else if (next === '{' && !accum.stagingTemplate) {
          accum.stagingTemplate = next
        } else if (accum.stagingTemplate && next === '{') {
          accum.stagingTemplate = '';
          accum.currentTemplate = '{{';
        } else if (accum.stagingTemplate) {
          accum.line += accum.stagingTemplate + next;
          accum.stagingTemplate = ''
        } else {
          accum.line += next;
        }

        return accum;
      }, {
        currentTemplate: '',
        stagingTemplate: '',
        line: '',
      });
      return reduce.line + reduce.stagingTemplate || reduce.currentTemplate;
    }).join('\n')

}

type FileDef = { fileName: string, fileContents: string };
type VimTemplates = {
  autoloadTemplate: string;
  colorsTemplate: string;
  afterTemplate: string;
  afterSyntaxTemplates: FileDef[]
};


function createDokiTheme(
  dokiFileDefinitionPath: string,
  dokiThemeDefinition: MasterDokiThemeDefinition,
  dokiTemplateDefinitions: DokiThemeDefinitions,
  dokiThemeVimDefinition: VimDokiThemeDefinition,
  vimTemplates: VimTemplates,
) {
  try {
    return {
      path: dokiFileDefinitionPath,
      definition: dokiThemeDefinition,
      autoloadTemplate: buildVimAutoLoadScript(
        dokiThemeDefinition,
        dokiTemplateDefinitions,
        dokiThemeVimDefinition,
        vimTemplates.autoloadTemplate,
      ),
      colorsTemplate: buildVimColorScript(
        dokiThemeDefinition,
        dokiTemplateDefinitions,
        dokiThemeVimDefinition,
        vimTemplates.colorsTemplate,
      ),
      afterTemplate: buildVimAfterScript(
        dokiThemeDefinition,
        dokiTemplateDefinitions,
        dokiThemeVimDefinition,
        vimTemplates.afterTemplate,
      ),
      afterSyntaxTemplates: buildVimSyntaxScript(
        dokiThemeDefinition,
        dokiTemplateDefinitions,
        dokiThemeVimDefinition,
        vimTemplates.afterSyntaxTemplates,
      )
    };
  } catch (e) {
    throw new Error(`Unable to build ${dokiThemeDefinition.name}'s theme for reasons ${e}`);
  }
}

const readJson = <T>(jsonPath: string): T =>
  JSON.parse(fs.readFileSync(jsonPath, 'utf-8'));

type TemplateTypes = StringDictonary<StringDictonary<string>>;

const isTemplate = (filePath: string): boolean =>
  !!getTemplateType(filePath);

const readTemplates = (templatePaths: string[]): TemplateTypes => {
  return templatePaths
    .filter(isTemplate)
    .map(templatePath => {
      return {
        type: getTemplateType(templatePath)!!,
        template: readJson<any>(templatePath)
      };
    })
    .reduce((accum: TemplateTypes, templateRepresentation) => {
      accum[templateRepresentation.type][templateRepresentation.template.name] =
        templateRepresentation.template;
      return accum;
    }, {
      [SYNTAX_TYPE]: {},
      [LAF_TYPE]: {},
      [NAMED_COLOR_TYPE]: {},
    });
};

function resolveStickerPath(
  themeDefinitionPath: string,
  sticker: string,
) {
  const stickerPath = path.resolve(
    path.resolve(themeDefinitionPath, '..'),
    sticker
  );
  return stickerPath.substr(masterThemeDefinitionDirectoryPath.length + '/definitions'.length);
}

console.log('Preparing to generate themes.');

walkDir(vimDefinitionDirectoryPath)
  .then((files) =>
    files.filter((file) => file.endsWith("vim.definition.json"))
  )
  .then((dokiThemeVimDefinitionPaths) => {
    return {
      dokiThemeVimDefinitions: dokiThemeVimDefinitionPaths
        .map((dokiThemeVimDefinitionPath) =>
          readJson<VimDokiThemeDefinition>(dokiThemeVimDefinitionPath)
        )
        .reduce(
          (accum: StringDictonary<VimDokiThemeDefinition>, def) => {
            accum[def.id] = def;
            return accum;
          },
          {}
        ),
    };
  }).then(({dokiThemeVimDefinitions}) =>
  walkDir(path.resolve(masterThemeDefinitionDirectoryPath, 'templates'))
    .then(readTemplates)
    .then(dokiTemplateDefinitions => {
      return walkDir(path.resolve(masterThemeDefinitionDirectoryPath, 'definitions'))
        .then(files => files.filter(file => file.endsWith('master.definition.json')))
        .then(dokiFileDefinitionPaths => {
          return {
            dokiThemeVimDefinitions,
            dokiTemplateDefinitions,
            dokiFileDefinitionPaths
          };
        });
    }))
  .then(templatesAndDefinitions =>
    walkDir(path.resolve(vimScriptTemplateDirectoryPath, 'syntax'))
      .then(vimSyntaxPaths => {
        return {
          ...templatesAndDefinitions,
          vimSyntaxFileDefs : vimSyntaxPaths.map(syntaxPath => ({
            fileName: path.basename(syntaxPath),
            fileContents: fs.readFileSync(syntaxPath,'utf-8'),
          }))
        }
      })
  )
  .then(templatesAndDefinitions => {
    const autoloadTemplate = fs.readFileSync(path.resolve(
      vimScriptTemplateDirectoryPath,
      'doki-theme.autoload.template.vim'
    ), {
      encoding: 'utf-8',
    });
    const colorsTemplate = fs.readFileSync(path.resolve(
      vimScriptTemplateDirectoryPath,
      'doki-theme.colors.template.vim',
    ), {
      encoding: 'utf-8'
    });
    const afterTemplate = fs.readFileSync(path.resolve(
      vimScriptTemplateDirectoryPath,
      'doki-theme.after.plugin.template.vim',
    ), {
      encoding: 'utf-8'
    });
    const vimTemplates = {
      autoloadTemplate,
      colorsTemplate,
      afterTemplate,
      afterSyntaxTemplates: templatesAndDefinitions.vimSyntaxFileDefs
    };
    const {
      dokiTemplateDefinitions,
      dokiThemeVimDefinitions,
      dokiFileDefinitionPaths
    } = templatesAndDefinitions;
    return dokiFileDefinitionPaths
      .map(dokiFileDefinitionPath => {
        const dokiThemeDefinition = readJson<MasterDokiThemeDefinition>(dokiFileDefinitionPath);
        const dokiThemeVimDefinition =
          dokiThemeVimDefinitions[dokiThemeDefinition.id];
        if (!dokiThemeVimDefinition) {
          throw new Error(
            `${dokiThemeDefinition.displayName}'s theme does not have a vim Definition!!`
          );
        }
        return ({
          dokiFileDefinitionPath,
          dokiThemeDefinition,
          dokiThemeVimDefinition,
        });
      })
      .filter(pathAndDefinition =>
        (pathAndDefinition.dokiThemeDefinition.product === 'ultimate' &&
          process.env.PRODUCT === 'ultimate') ||
        pathAndDefinition.dokiThemeDefinition.product !== 'ultimate'
      )
      .map(({
              dokiFileDefinitionPath,
              dokiThemeDefinition,
              dokiThemeVimDefinition,
            }) =>
        createDokiTheme(
          dokiFileDefinitionPath,
          dokiThemeDefinition,
          dokiTemplateDefinitions,
          dokiThemeVimDefinition,
          vimTemplates
        )
      );
  }).then(dokiThemes => {
  // write things for extension
  dokiThemes.forEach(dokiTheme => {
    const vimName = constructVimName(dokiTheme.definition);
    const dokiThemeVimScriptName = `${vimName}.vim`;

    // write Vim Color Script
    fs.writeFileSync(path.resolve(colorDirectoryPath, dokiThemeVimScriptName), dokiTheme.colorsTemplate);

    // write Vim after plugin Script
    fs.writeFileSync(path.resolve(afterDirectoryPath, 'plugin', dokiThemeVimScriptName), dokiTheme.afterTemplate);

    // write Vim Syntax Highlighting things
    dokiTheme.afterSyntaxTemplates.forEach(({
      fileName, fileContents
                                            })=> {
      fs.writeFileSync(path.resolve(afterDirectoryPath, 'syntax', `${vimName}_${fileName}`), fileContents);
    });

    // write Vim Auto load Script
    fs.writeFileSync(path.resolve(autoLoadDirectoryPath, dokiThemeVimScriptName), dokiTheme.autoloadTemplate);
  })

})
  .then(() => {
    console.log('Theme Generation Complete!');
  });
