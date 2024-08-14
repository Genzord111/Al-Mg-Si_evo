//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html
#include "evolutionTestApp.h"
#include "evolutionApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "MooseSyntax.h"

InputParameters
evolutionTestApp::validParams()
{
  InputParameters params = evolutionApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  params.set<bool>("use_legacy_initial_residual_evaluation_behavior") = false;
  return params;
}

evolutionTestApp::evolutionTestApp(InputParameters parameters) : MooseApp(parameters)
{
  evolutionTestApp::registerAll(
      _factory, _action_factory, _syntax, getParam<bool>("allow_test_objects"));
}

evolutionTestApp::~evolutionTestApp() {}

void
evolutionTestApp::registerAll(Factory & f, ActionFactory & af, Syntax & s, bool use_test_objs)
{
  evolutionApp::registerAll(f, af, s);
  if (use_test_objs)
  {
    Registry::registerObjectsTo(f, {"evolutionTestApp"});
    Registry::registerActionsTo(af, {"evolutionTestApp"});
  }
}

void
evolutionTestApp::registerApps()
{
  registerApp(evolutionApp);
  registerApp(evolutionTestApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
// External entry point for dynamic application loading
extern "C" void
evolutionTestApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  evolutionTestApp::registerAll(f, af, s);
}
extern "C" void
evolutionTestApp__registerApps()
{
  evolutionTestApp::registerApps();
}
