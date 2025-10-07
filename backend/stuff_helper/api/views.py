from rest_framework import generics, permissions
from core.models import Services, Benefit, Request
from api.serializers import BenefitSerializer, RequestSerializer, ServicesSerializer


class ServicesListView(generics.ListAPIView):
    serializer_class = ServicesSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return Services.objects.filter(is_active=True)


class BenefitListView(generics.ListAPIView):
    serializer_class = BenefitSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return Benefit.objects.filter(is_active=True)


class RequestListCreateView(generics.ListCreateAPIView):
    serializer_class = RequestSerializer
    queryset = Request.objects.all()
    permission_classes = [permissions.IsAuthenticated]

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class RequestDetailView(generics.RetrieveAPIView):
    serializer_class = RequestSerializer
    queryset = Request.objects.all()
    permission_classes = [permissions.IsAuthenticated]


class RequestDeleteView(generics.DestroyAPIView):
    serializer_class = RequestSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return Request.objects.filter(user=self.request.user)
