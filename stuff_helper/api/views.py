from rest_framework import generics
from core.models import Services, Benefit, Request
from .serializers import BenefitSerializer, RequestSerializer, ServicesSerializer


class ServicesListView(generics.ListAPIView):
    serializer_class = ServicesSerializer

    def get_queryset(self):
        return Services.objects.filter(is_active=True)

class BenefitListView(generics.ListAPIView):
    serializer_class = BenefitSerializer

    def get_queryset(self):
        return Benefit.objects.filter(is_active=True)


class RequestListCreateView(generics.ListCreateAPIView):
    serializer_class = RequestSerializer
    queryset = Request.objects.all()


class RequestDetailView(generics.RetrieveAPIView):
    serializer_class = RequestSerializer
    queryset = Request.objects.all()
