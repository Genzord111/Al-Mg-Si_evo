#include "evolutionApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"

InputParameters
evolutionApp::validParams()
{
  InputParameters params = MooseApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  params.set<bool>("use_legacy_initial_residual_evaluation_behavior") = false;
  return params;
}

evolutionApp::evolutionApp(InputParameters parameters) : MooseApp(parameters)
{
  evolutionApp::registerAll(_factory, _action_factory, _syntax);
}

evolutionApp::~evolutionApp() {}

void
evolutionApp::registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  ModulesApp::registerAllObjects<evolutionApp>(f, af, s);
  Registry::registerObjectsTo(f, {"evolutionApp"});
  Registry::registerActionsTo(af, {"evolutionApp"});

  /* register custom execute flags, action syntax, etc. here */
}

void
evolutionApp::registerApps()
{
  registerApp(evolutionApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
extern "C" void
evolutionApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  evolutionApp::registerAll(f, af, s);
}
extern "C" void
evolutionApp__registerApps()
{
  evolutionApp::registerApps();
}
