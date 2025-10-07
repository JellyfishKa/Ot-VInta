from django.contrib.auth import authenticate
from rest_framework import serializers


class UserLoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField(write_only=True)

    def validate(self, attrs):
        username = attrs.get('username')
        password = attrs.get('password')

        if username and password:
            user = authenticate(username=username, password=password)
            if not user:
                raise serializers.ValidationError("Invalid credentials or inactive account.")
        else:
            raise serializers.ValidationError("Both username and password are required.")
        attrs['user'] = user
        return attrs