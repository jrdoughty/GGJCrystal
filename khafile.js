let project = new Project('Crystals');
project.addAssets('Assets/**');
project.addLibrary('Sdg');
project.addSources('Sources');
project.windowOptions.width = 920;
project.windowOptions.height = 760;
resolve(project);
