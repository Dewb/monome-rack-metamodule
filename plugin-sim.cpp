#include "rack.hpp"

using namespace rack;

extern Plugin* pluginInstance;
extern void initPluginImpl(Plugin* p);

void init_MonomeMM(Plugin* p)
{
    pluginInstance = p;

    initPluginImpl(p);
}
