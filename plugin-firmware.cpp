#include "rack.hpp"

using namespace rack;

Plugin* pluginInstance;
extern void initPluginImpl(Plugin* p);

void init(Plugin* p)
{
    pluginInstance = p;

    initPluginImpl(p);
}
