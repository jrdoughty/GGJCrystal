let project = new Project('Crystals');
project.addAssets('Assets/**');
project.addLibrary('Sdg');
project.addSources('Sources');
project.windowOptions.width = 640;
project.windowOptions.height = 480;
resolve(project);
