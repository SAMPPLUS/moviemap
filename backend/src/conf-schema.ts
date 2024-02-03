import { convertFromDirectory } from 'joi-to-typescript';

convertFromDirectory({
  schemaDirectory: './schemas',
  typeOutputDirectory: './interfaces/requests',
  schemaFileSuffix: '.schema',
  interfaceFileSuffix: '.intr',
  debug: true
})