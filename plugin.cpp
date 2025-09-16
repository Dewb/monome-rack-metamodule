#include "AnsibleModule.hpp"
#include "AnsibleWidget.hpp"
#include "EarthseaModule.hpp"
#include "EarthseaWidget.hpp"
#include "MeadowphysicsModule.hpp"
#include "MeadowphysicsWidget.hpp"
#include "TeletypeModule.hpp"
#include "TeletypeWidget.hpp"
#include "WhiteWhaleModule.hpp"
#include "WhiteWhaleWidget.hpp"
//#include "TeletypeKeyboard.hpp"

using namespace rack;

Plugin* pluginInstance;

void init(Plugin* p)
{
    pluginInstance = p;

    Model* modelWhiteWhale = createModel<WhiteWhaleModule, WhiteWhaleWidget>("whitewhale");
    Model* modelMeadowphysics = createModel<MeadowphysicsModule, MeadowphysicsWidget>("meadowphysics");
    Model* modelEarthsea = createModel<EarthseaModule, EarthseaWidget>("earthsea");

    Model* modelTeletype = createModel<TeletypeModule, TeletypeWidget>("teletype");
    Model* modelAnsible = createModel<AnsibleModule, AnsibleWidget>("ansible");

    p->addModel(modelWhiteWhale);
    p->addModel(modelMeadowphysics);
    p->addModel(modelEarthsea);
    
    p->addModel(modelTeletype);
    p->addModel(modelAnsible);

    initThemes();
}
