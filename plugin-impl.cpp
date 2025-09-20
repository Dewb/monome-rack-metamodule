#include "AnsibleModule.hpp"
#include "AnsibleWidget.hpp"
#include "EarthseaModule.hpp"
#include "EarthseaWidget.hpp"
#include "MeadowphysicsModule.hpp"
#include "MeadowphysicsWidget.hpp"
#include "TeletypeModule.hpp"
#include "TeletypeWidget.hpp"
#include "VirtualGridModule.hpp"
#include "VirtualGridWidget.hpp"
#include "WhiteWhaleModule.hpp"
#include "WhiteWhaleWidget.hpp"
//#include "TeletypeKeyboard.hpp"

using namespace rack;

void initPluginImpl(Plugin* p)
{
    Model* modelWhiteWhale = createModel<WhiteWhaleModule, WhiteWhaleWidget>("whitewhale");
    Model* modelMeadowphysics = createModel<MeadowphysicsModule, MeadowphysicsWidget>("meadowphysics");
    Model* modelEarthsea = createModel<EarthseaModule, EarthseaWidget>("earthsea");

    Model* modelTeletype = createModel<TeletypeModule, TeletypeWidget>("teletype");
    Model* modelAnsible = createModel<AnsibleModule, AnsibleWidget>("ansible");

    Model* modelGrid128 = createModel<VirtualGridModuleTemplate<16, 8>, VirtualGridWidgetTemplate<16, 8>>("grid128");
    Model* modelGrid64 = createModel<VirtualGridModuleTemplate<8, 8>, VirtualGridWidgetTemplate<8, 8>>("grid64");
    Model* modelGrid256 = createModel<VirtualGridModuleTemplate<16, 16>, VirtualGridWidgetTemplate<16, 16>>("grid256");

    p->addModel(modelWhiteWhale);
    p->addModel(modelMeadowphysics);
    p->addModel(modelEarthsea);
    
    p->addModel(modelTeletype);
    p->addModel(modelAnsible);

    p->addModel(modelGrid128);
    p->addModel(modelGrid64);
    p->addModel(modelGrid256);

    initThemes();
}
