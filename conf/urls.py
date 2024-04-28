from django.urls import re_path
from django.conf.urls import include
from allianceauth import urls
from mumbletemps.views import link  # *** New Import 

urlpatterns = [
    re_path(r'^mumbletemps/join/(?P<link_ref>[\w\-]+)/$', link, name='join'),  # *** New URL override BEFORE THE MAIN IMPORT
    re_path(r'', include(urls)),
]

handler500 = 'allianceauth.views.Generic500Redirect' 
handler404 = 'allianceauth.views.Generic404Redirect'
handler403 = 'allianceauth.views.Generic403Redirect'
handler400 = 'allianceauth.views.Generic400Redirect' 